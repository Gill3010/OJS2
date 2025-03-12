<?php
/* Smarty version 4.3.1, created on 2025-03-11 23:37:24
  from 'app:frontendcomponentsbannerRevista.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '4.3.1',
  'unifunc' => 'content_67d0c9343b1a31_42172172',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '439523fa089f77270c441336360a36b7ab012bff' => 
    array (
      0 => 'app:frontendcomponentsbannerRevista.tpl',
      1 => 1741275797,
      2 => 'app',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_67d0c9343b1a31_42172172 (Smarty_Internal_Template $_smarty_tpl) {
if ($_smarty_tpl->tpl_vars['currentContext']->value) {?>
    <!-- Banner visible solo en la revista -->
    <div class="revista-banner">
        <img src="<?php echo $_smarty_tpl->tpl_vars['baseUrl']->value;?>
/public/banners/bannerRevista1.png" alt="Banner de la Revista" class="img-responsive">
    </div>
<?php }
}
}
