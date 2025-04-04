<link rel="stylesheet" type="text/css" href="{$baseUrl}/plugins/themes/bootstrap3/styles/customCarousel.css">

{if !$currentContext}
    <!-- Carrusel -->
    <div id="carouselExample" class="carousel slide" data-ride="carousel" data-interval="3000">
        
        <!-- Formulario de búsqueda centrado -->
        <div class="search-overlay">
            <form class="navbar-form" role="search" method="post" action="{url page="search" op="search"}">
                <div class="form-group">
                    <input class="form-control" name="query" value="{$searchQuery|escape}" type="search" 
                           aria-label="{translate|escape key="common.searchQuery"}" placeholder="Buscar...">
                </div>
                <button type="submit" class="btn btn-default">{translate key="common.search"}</button>
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
                <img src="{$baseUrl}/public/carousel/image1.png" alt="Imagen 1" class="img-responsive">
            </div>
            <div class="item">
                <img src="{$baseUrl}/public/carousel/image2.png" alt="Imagen 2" class="img-responsive">
            </div>
            <div class="item">
                <img src="{$baseUrl}/public/carousel/image3.png" alt="Imagen 3" class="img-responsive">
            </div>
            <div class="item">
                <img src="{$baseUrl}/public/carousel/image4.png" alt="Imagen 4" class="img-responsive">
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
{/if}
