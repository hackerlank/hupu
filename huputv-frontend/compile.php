<?php
$SMARTY = '/data/www-data/hupu.com/smarty/Smarty.class.php';
$ROOT = getcwd();
require($SMARTY);

$smarty = new Smarty();
$smarty->setPluginsDir(array(
    $ROOT . '/output/plugin'
));
$smarty->left_delimiter = '{%';
$smarty->right_delimiter = '%}';
$smarty->setTemplateDir($ROOT . '/output/template');
$smarty->setCompileDir($ROOT . '/output/template_c');
$smarty->setConfigDir($ROOT . '/output/config');
$smarty->compileAllTemplates(".tpl", true);