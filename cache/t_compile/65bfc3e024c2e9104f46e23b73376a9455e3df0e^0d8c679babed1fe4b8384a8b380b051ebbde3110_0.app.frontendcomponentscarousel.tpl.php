<?php
/* Smarty version 4.3.1, created on 2025-03-11 23:48:45
  from 'app:frontendcomponentscarousel.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '4.3.1',
  'unifunc' => 'content_67d0cbddb6fa25_49975205',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '0d8c679babed1fe4b8384a8b380b051ebbde3110' => 
    array (
      0 => 'app:frontendcomponentscarousel.tpl',
      1 => 1741304791,
      2 => 'app',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_67d0cbddb6fa25_49975205 (Smarty_Internal_Template $_smarty_tpl) {
?><link rel="stylesheet" type="text/css" href="<?php echo $_smarty_tpl->tpl_vars['baseUrl']->value;?>
/plugins/themes/bootstrap3/styles/customCarousel.css">
<?php if (!$_smarty_tpl->tpl_vars['currentContext']->value) {?>
    <!-- Carrusel visible solo en el portal -->
    <div id="carouselExample" class="carousel slide" data-ride="carousel" data-interval="3000">
        <!-- Indicadores -->
        <ol class="carousel-indicators">
            <li data-target="#carouselExample" data-slide-to="0" class="active"></li>
            <li data-target="#carouselExample" data-slide-to="1"></li>
            <li data-target="#carouselExample" data-slide-to="2"></li>
            <li data-target="#carouselExample" data-slide-to="3"></li>
        </ol>

        <!-- Imágenes del carrusel -->
        <div class="carousel-inner">
            <div class="item active">
                <img src="<?php echo $_smarty_tpl->tpl_vars['baseUrl']->value;?>
/public/carousel/image1.png" alt="Imagen 1" class="img-responsive">
            </div>
            <div class="item">
                <img src="<?php echo $_smarty_tpl->tpl_vars['baseUrl']->value;?>
/public/carousel/image2.png" alt="Imagen 2" class="img-responsive">
            </div>
            <div class="item">
                <img src="<?php echo $_smarty_tpl->tpl_vars['baseUrl']->value;?>
/public/carousel/image3.png" alt="Imagen 3" class="img-responsive">
            </div>
            <div class="item">
                <img src="<?php echo $_smarty_tpl->tpl_vars['baseUrl']->value;?>
/public/carousel/image4.png" alt="Imagen 4" class="img-responsive">
            </div>
        </div>

        <!-- Controles de navegación -->
        <a class="left carousel-control" href="#carouselExample" data-slide="prev">
            <span class="glyphicon glyphicon-chevron-left"></span>
        </a>
        <a class="right carousel-control" href="#carouselExample" data-slide="next">
            <span class="glyphicon glyphicon-chevron-right"></span>
        </a>
    </div>
<?php }
}
}
