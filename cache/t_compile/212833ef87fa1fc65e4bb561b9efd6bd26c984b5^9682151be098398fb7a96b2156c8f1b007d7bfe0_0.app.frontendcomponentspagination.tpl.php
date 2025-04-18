<?php
/* Smarty version 4.3.1, created on 2025-03-14 16:41:13
  from 'app:frontendcomponentspagination.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '4.3.1',
  'unifunc' => 'content_67d45c2991ee59_85493820',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '9682151be098398fb7a96b2156c8f1b007d7bfe0' => 
    array (
      0 => 'app:frontendcomponentspagination.tpl',
      1 => 1740105946,
      2 => 'app',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_67d45c2991ee59_85493820 (Smarty_Internal_Template $_smarty_tpl) {
if ($_smarty_tpl->tpl_vars['prevUrl']->value || $_smarty_tpl->tpl_vars['nextUrl']->value) {?>
	<nav aria-label="<?php echo call_user_func_array($_smarty_tpl->registered_plugins[ 'modifier' ][ 'escape' ][ 0 ], array( call_user_func_array( $_smarty_tpl->smarty->registered_plugins[Smarty::PLUGIN_FUNCTION]['translate'][0], array( array('key'=>"common.pagination.label"),$_smarty_tpl ) ) ));?>
">
		<ul class="pager">
			<?php if ($_smarty_tpl->tpl_vars['prevUrl']->value) {?>
				<li class="previous">
					<a href="<?php echo $_smarty_tpl->tpl_vars['prevUrl']->value;?>
">
						<span aria-hidden="true">&larr;</span>
						<?php echo call_user_func_array( $_smarty_tpl->smarty->registered_plugins[Smarty::PLUGIN_FUNCTION]['translate'][0], array( array('key'=>"help.previous"),$_smarty_tpl ) );?>

					</a>
				</li>
			<?php }?>
			<li class="current">
				<?php echo call_user_func_array( $_smarty_tpl->smarty->registered_plugins[Smarty::PLUGIN_FUNCTION]['translate'][0], array( array('key'=>"common.pagination",'start'=>$_smarty_tpl->tpl_vars['showingStart']->value,'end'=>$_smarty_tpl->tpl_vars['showingEnd']->value,'total'=>$_smarty_tpl->tpl_vars['total']->value),$_smarty_tpl ) );?>

			</li>
			<?php if ($_smarty_tpl->tpl_vars['nextUrl']->value) {?>
			<li class="next">
				<a class="next" href="<?php echo $_smarty_tpl->tpl_vars['nextUrl']->value;?>
">
					<?php echo call_user_func_array( $_smarty_tpl->smarty->registered_plugins[Smarty::PLUGIN_FUNCTION]['translate'][0], array( array('key'=>"help.next"),$_smarty_tpl ) );?>

					<span aria-hidden="true">&rarr;</span>
				</a>
			</li>
			<?php }?>
		</ul>
	</nav>
<?php }
}
}
