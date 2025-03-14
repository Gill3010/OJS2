<?php
/* Smarty version 4.3.1, created on 2025-03-14 19:16:09
  from 'app:frontendcomponentscarousel.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '4.3.1',
  'unifunc' => 'content_67d480790c5999_78533994',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '0d8c679babed1fe4b8384a8b380b051ebbde3110' => 
    array (
      0 => 'app:frontendcomponentscarousel.tpl',
      1 => 1741963675,
      2 => 'app',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_67d480790c5999_78533994 (Smarty_Internal_Template $_smarty_tpl) {
?><link rel="stylesheet" type="text/css" href="<?php echo $_smarty_tpl->tpl_vars['baseUrl']->value;?>
/plugins/themes/bootstrap3/styles/customCarousel.css">

<?php if (!$_smarty_tpl->tpl_vars['currentContext']->value) {?>
    <!-- Carrusel -->
    <div id="carouselExample" class="carousel slide" data-ride="carousel" data-interval="3000">
        
        <!-- Formulario de búsqueda centrado -->
        <div class="search-overlay">
            <form class="navbar-form" role="search" method="post" action="<?php echo call_user_func_array( $_smarty_tpl->smarty->registered_plugins[Smarty::PLUGIN_FUNCTION]['url'][0], array( array('page'=>"search",'op'=>"search"),$_smarty_tpl ) );?>
">
                <div class="form-group">
                    <input class="form-control" name="query" value="<?php echo call_user_func_array($_smarty_tpl->registered_plugins[ 'modifier' ][ 'escape' ][ 0 ], array( $_smarty_tpl->tpl_vars['searchQuery']->value ));?>
" type="search" 
                           aria-label="<?php echo call_user_func_array($_smarty_tpl->registered_plugins[ 'modifier' ][ 'escape' ][ 0 ], array( call_user_func_array( $_smarty_tpl->smarty->registered_plugins[Smarty::PLUGIN_FUNCTION]['translate'][0], array( array('key'=>"common.searchQuery"),$_smarty_tpl ) ) ));?>
" placeholder="Buscar...">
                </div>
                <button type="submit" class="btn btn-default"><?php echo call_user_func_array( $_smarty_tpl->smarty->registered_plugins[Smarty::PLUGIN_FUNCTION]['translate'][0], array( array('key'=>"common.search"),$_smarty_tpl ) );?>
</button>
            </form>
        </div>

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
