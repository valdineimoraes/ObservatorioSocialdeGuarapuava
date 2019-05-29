//= require simplemde/simplemde.min

window.OBS = {};

$(document).on('turbolinks:load', function() {
    OBS.loadMarkdownEditor();
});

OBS.loadMarkdownEditor = function () {
    $('.markdown-editor').each(function () {
        var id = $(this).attr('id');
        new SimpleMDE({ element: document.getElementById(id) });
    });

    $('.markdown-content').each(function () {
        var markdown = $(this).data('markdown');
        var html = SimpleMDE.prototype.markdown(markdown);

        $(this).html(html);
    })
};

$('.sidebar-toggle').pushMenu();
