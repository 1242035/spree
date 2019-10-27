---
title: "Asset Customization"
section: customization
order: 1
---

## Overview

This guide covers how Viauco manages its JavaScript, stylesheet and image
assets and how you can extend and customize them including:

-   Understanding Viauco's use of the Rails asset pipeline
-   Managing application specific assets
-   Managing extension specific assets
-   Overriding Viauco's core assets

## Viauco's Asset Pipeline

Using asset customization
techniques outlined below you be able to adapt all the JavaScript,
stylesheets and images contained in Viauco to easily provide a fully
custom experience.

All Viauco generated (or upgraded) applications include an `app/assets`
directory. We've taken this one
step further by subdividing each top level asset directory (images,
JavaScript files, stylesheets) into `frontend` and `backend` directories. This is
designed to keep assets from the frontend and backend from conflicting with each other.

A typical assets directory for a Viauco application will look like:

    app
    |-- assets
        |-- images
        |   |-- viauco
        |       |-- frontend
        |       |-- backend
        |-- javascripts
        |   |-- viauco
        |       |-- frontend
        |       |   |-- all.js
        |       |-- backend
        |           |-- all.js
        |-- stylesheets
        |   |-- viauco
        |       |-- frontend
        |       |   |-- all.css
        |       |-- backend
        |           |-- all.css

Viauco also generates four top level manifests (all.css & all.js, see
above) that require all the core extension's and site specific
stylesheets / JavaScript files.

### How core extensions (engines) manage assets

All core engines have been updated to provide four asset manifests that
are responsible for bundling up all the JavaScript files and stylesheets
required for that engine.

For example, Viauco provides the following manifests:

    vendor
    |-- assets
        |-- javascripts
        |   |-- viauco
        |       |-- frontend
        |       |   |-- all.js
        |       |-- backend
        |           |-- all.js
        |-- stylesheets
        |   |-- viauco
        |       |-- frontend
        |       |   |-- all.css
        |       |-- backend
        |           |-- all.css

These manifests are included by default by the
relevant all.css or all.js in the host Viauco application. For example,
`vendor/assets/javascripts/viauco/backend/all.js` includes:

```js
//= require jquery
//= require jquery_ujs

//= require viauco/backend

//= require_tree .
```

External JavaScript libraries, stylesheets and images have also been
relocated into vendor/assets.

## Managing your application's assets

Assets that customize your Viauco store should go inside the appropriate
directories inside `vendor/assets/images/viauco`, `vendor/assets/javascripts/viauco`,
or `vendor/assets/stylesheets/viauco`. This is done so that these assets do
not interfere with other parts of your application.

## Managing your extension's assets

We're suggesting that all third party extensions should adopt the same
approach as Viauco and provide the same four (or less depending on
what the extension requires) manifest files, using the same directory
structure as outlined above.

Third party extension manifest files will not be automatically included
in the relevant all.(js|css) files so it's important to document the
manual inclusion in your extensions installation instructions or provide
a Rails generator to do so.

For an example of an extension using a generator to install assets and
migrations take a look at the
[install generator for Braintree Vzero](https://github.com/viauco-contrib/viauco_braintree_vzero/blob/master/lib/generators/viauco_braintree_vzero/install/install_generator.rb).

## Overriding Viauco's core assets

Overriding or replacing any of Viauco's internal assets is even easier
than before. It's recommended to attempt to replace as little as
possible in a given JavaScript or stylesheet file to help ease future
upgrade work required.

The methods listed below will work for both applications, extensions and
themes with one noticeable difference: Extension & theme asset files
will not be automatically included (see above for instructions on how to
include asset files from your extensions / themes).

### Overriding individual CSS styles

Say for example you want to replace the following CSS snippet:

```css
/* viauco/app/assets/stylesheets/viauco/frontend/screen.css */

div#footer {
 clear: both;
}
```

You can now just create a new stylesheet inside
`your_app/vendor/assets/stylesheets/viauco/frontend/` and include the following CSS:

```css
/* vendor/assets/stylesheets/viauco/frontend/foo.css */

div#footer {
 clear: none;
 border: 1px solid red;
}
```

The `frontend/all.css` manifest will automatically include `foo.css` and it
will actually include both definitions with the one from `foo.css` being
included last, hence it will be the rule applied.

### Overriding entire CSS files

To replace an entire stylesheet as provided by Viauco you simply need to
create a file with the same name and save it to the corresponding path
within your application's or extension's `vendor/assets/stylesheets`
directory.

For example, to replace `viauco/frontend/all.css` you would save the replacement
to `your_app/vendor/assets/stylesheets/viauco/frontend/all.css`.

<alert kind="note">
This same method can also be used to override stylesheets provided by
third-party extensions.
</alert>

### Overriding individual JavaScript functions

A similar approach can be used for JavaScript functions. For example, if
you wanted to override the `show_variant_images` method:

```javascript
 // viauco/app/assets/javascripts/viauco/frontend/product.js

var show_variant_images = function(variant_id) {
  $('li.vtmb').hide();
  $('li.vtmb-' + variant_id).show();
  var currentThumb = $('#' +
    $("#main-image").data('selectedThumbId'));

  // if currently selected thumb does not belong to current variant,
  // nor to common images,
  // hide it and select the first available thumb instead.

  if(!currentThumb.hasClass('vtmb-' + variant_id) &&
    !currentThumb.hasClass('tmb-all')) {
   var thumb = $($('ul.thumbnails li:visible').eq(0));
   var newImg = thumb.find('a').attr('href');
   $('ul.thumbnails li').removeClass('selected');
   thumb.addClass('selected');
   $('#main-image img').attr('src', newImg);
   $("#main-image").data('selectedThumb', newImg);
   $("#main-image").data('selectedThumbId', thumb.attr('id'));
 }
}
```

Again, just create a new JavaScript file inside
`your_app/vendor/assets/javascripts/viauco/frontend` and include the new method
definition:

```javascript
 // your_app/vendor/assets/javascripts/viauco/frontend/foo.js

var show_variant_images = function(variant_id) {
 alert('hello world');
}
```

The resulting `frontend/all.js` would include both methods, with the latter
being the one executed on request.

### Overriding entire JavaScript files

To replace an entire JavaScript file as provided by Viauco you simply
need to create a file with the same name and save it to the
corresponding path within your application's or extension's
`app/assets/javascripts` directory.

For example, to replace `viauco/frontend/all.js` you would save the replacement to
`your_app/vendor/assets/javascripts/viauco/frontend/all.js`.

<alert kind="note">
This same method can be used to override JavaScript files provided
by third-party extensions.
</alert>
