document.addEventListener('DOMContentLoaded', function () {
    const slider = document.getElementById('customSlider');
    const slides = slider.getElementsByClassName('custom-slide');
    let index = 0;
    const totalSlides = slides.length;

    // Mover al siguiente slide
    function moveSlide(direction) {
        index = (index + direction + totalSlides) % totalSlides; // Cálculo para mover hacia adelante o atrás
        updateSliderPosition();
    }

    // Actualizar la posición del slider
    function updateSliderPosition() {
        slider.style.transform = `translateX(-${index * 100}%)`;
    }

    // Activar la navegación automática (cambiar cada 5 segundos)
    function startAutoSlide() {
        setInterval(function () {
            moveSlide(1); // Mover al siguiente slide cada 5 segundos
        }, 5000);
    }

    // Iniciar la navegación automática
    startAutoSlide();

    // Asignar los eventos de los botones manuales
    document.querySelector('.custom-prev').addEventListener('click', function () {
        moveSlide(-1);
    });

    document.querySelector('.custom-next').addEventListener('click', function () {
        moveSlide(1);
    });
});
