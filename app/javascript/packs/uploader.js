document.addEventListener('turbo:load', function() {
    const imageInputs = document.querySelectorAll('.upload-input');
    const previewImages = document.querySelectorAll('.preview-image');

    imageInputs.forEach(function(imageInput, index) {
        imageInput.addEventListener('change', function(event) {
            const selectedFile = event.target.files[0];

            if (selectedFile) {
                const imageUrl = URL.createObjectURL(selectedFile);

                previewImages[index].src = imageUrl;
                previewImages[index].style.display = 'inline';
            }
        });
    });
});
