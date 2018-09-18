<?php
/** 
 *           File:  doc.php
 *         Author:  Alvan
 *       Modifier:  Alvan
 *       Modified:  2015-07-02
 *    Description:  Generate PHP manual for Vim
 *          Usage:  1. Download PHP manual from http://php.net/get/php_manual_en.tar.gz/from/a/mirror
 *                  2. Extract all files into an directory src/
 *                  3. Run in terminal: php doc.php
 */
error_reporting(E_ALL);
ini_set('display_errors', 'on');

date_default_timezone_set(@date_default_timezone_get());
mb_internal_encoding('UTF-8');

define('DIR_SRC', __DIR__ . '/src/');
define('DIR_TMP', __DIR__ . '/tmp/');
define('DIR_DOC', __DIR__ . '/doc/');
define('NUM_COL', 78);
define('STR_TAB', '    ');

$dir = dir(DIR_SRC);
$dir OR exit('Failed to open src directory');

file_exists(DIR_TMP) OR mkdir(DIR_TMP, 0777, true);
file_exists(DIR_DOC) OR mkdir(DIR_DOC, 0777, true);

$tns = array();
while (false !== ($src = $dir->read()))
{
	if (preg_match('/^function\./', $src))
	{
		printf('[%s] %s' . PHP_EOL, date('c'), 'Processing ' . $src);

		$tmp = DIR_TMP . $src;
		$doc = DIR_DOC . preg_replace('/^function\./', '', preg_replace('/html$/', 'txt', $src));

		$htm = file_get_contents($dir->path . $src);
		if (preg_match('#<h1[^>]*>([^<]+)</h1>#', $htm, $mas))
			$tag = $mas[1];
		else
			continue;

		$htm = preg_replace_callback('#(<div class="methodsynopsis dc-description">)(.+?)(</div>)#s', function($mas) {
			return $mas[1] . '<br>' . wordwrap(
				preg_replace('#(?:\s+){2,}#', ' ', trim(str_replace(array("\r", "\n"), '', strip_tags($mas[2])))),
				NUM_COL - 1 - strlen(STR_TAB),
				'~<br>'
			) . '~' .  $mas[3];
		}, $htm);
		$htm = preg_replace_callback('#(<h3[^>]*>)(.+?)(</h3>)#', function($mas) {
			return $mas[1] . str_repeat('=', NUM_COL) . '<br>*' . implode('* *', explode(' ', $mas[2])) . '*' . $mas[3];
		}, $htm);
		$htm = preg_replace_callback('#(<strong[^>]+class="command"[^>]*>)(.+?)(</strong>)#', function($mas) {
			return $mas[1] . '`' . implode('` `', explode(' ', $mas[2])) . '`' . $mas[3];
		}, $htm);
		$htm = preg_replace('#(<code class="parameter">)([^$]+?)(</code>)#', '\1{\2}\3', $htm);
		$htm = preg_replace('#(<a[^>]*href="function\.[^.]+\.html"[^>]*>)([^\(]+?)(?:\(\))?(</a>)#', '\1|\2|\3', $htm);
		$htm = preg_replace('#<div[^>]+class="manualnavbar".*?</div><hr(?: /)?>#s', '', $htm);
		$htm = preg_replace('#<hr(?: /)?><div[^>]+class="manualnavbar".*?</div></body>#s', '</body>', $htm);
		
		file_put_contents($tmp, $htm);

        system(sprintf('w3m -cols %d -t %d -o indent_incr=%d -no-graph %s > %s',
            NUM_COL + 1, strlen(STR_TAB), strlen(STR_TAB), escapeshellarg($tmp), escapeshellarg($doc)));

		$txt = file_get_contents($doc);
		$txt = preg_replace('#^\s?([^\s].+~)$#m', STR_TAB . '\1', $txt);
		$txt = preg_replace('#^(\s*?<\?php\s*?)$#m', '\1 >', $txt);
		$txt = preg_replace_callback('#^(<\?php\s+>)(.+?)([\r\n]+\?>)$#ms', function($mas) {
			return $mas[1] . preg_replace('#([\r\n]+)#', '\1' . STR_TAB, $mas[2]) . $mas[3];
		}, $txt);
		$txt = preg_replace('#^([\t ]*\?>\s*?)$#m', '<\1', $txt);

		$lns = explode("\n", str_replace("\r\n", "\n", $txt));
		$pre = 0;
		for ($i = 0, $c = count($lns); $i < $c; $i++)
		{
			if ($pre > 0 && isset($lns[$i][0]) && preg_match('/[^\s]/', $lns[$i][0]))
			{
				--$pre;
				continue;
			}
			else if (preg_match('/.>$/', $lns[$i]))
			{
				++$pre;
				continue;
			}

			if ($pre > 0)
			{
				continue;
			}

			foreach (array('`' => '`', '|' => '|', '*' => '*', '{' => '}') as $key => $val)
			{
				$num = $pos = 0;
				for ($x = 0, $l = strlen($lns[$i]); $x < $l; $x++)
				{
					if ($lns[$i][$x] == $key)
					{
						$pos = $x;
						++$num;
					}
				}

				if ($pos && ($num % 2) > 0 && $c - $i > 1 && ($s = strpos($lns[$i+1], $val)))
				{
					$end = substr($lns[$i], $pos + 1);
					if (preg_match('/^[-a-zA-Z0-9_]*$/', $end)
						&& preg_match('/^(\s*)[-a-zA-Z0-9_]+$/', substr($lns[$i+1], 0, $s), $mas))
					{
						$lns[$i] = substr($lns[$i], 0, $pos);
						$lns[$i+1] = $mas[1] . $key . $end . ltrim($lns[$i+1]);
					}
				}
			}
		}

		file_put_contents($doc, implode(PHP_EOL, $lns) . PHP_EOL . 'vim:ft=help:');

        $tns[] = "${tag}\t" . basename($doc) . "\t/^${tag}";
	}
}

file_put_contents(DIR_DOC . 'tags', implode("\n", $tns), LOCK_EX);
system('vim +%sort +wq ' . escapeshellarg(DIR_DOC . 'tags'));
