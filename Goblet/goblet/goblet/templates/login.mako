<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width"/>
    <link rel="stylesheet" href="/pyaellacss/app.css"/>
    <script src="/pyaellascripts/vendor/custom.modernizr.js"></script>

    <title>Mividio :: Login</title>

    <%namespace name="authbanner" file="authbanner.mako"/>

</head>
<body>

<!-- Header -->
<div id="div-header" class="">
    ${authbanner.get_auth_banner(url, came_from, login, password, logged_in)}
</div>

<div id="div-help-links" class="">
    <ul>
        <li><a href="/faq">FAQ</a>
        <li><a href="/users/create">Register</a>
        <li><a href="/forgot">Forgot password?</a>
    </ul>
</div>

<div id="messages">
    ${message}
</div>


<script>
    document.write('<script src=' +
            ('__proto__' in {} ? '/pyaellascripts/vendor/zepto' : '/pyaellascripts/vendor/jquery') +
            '.js><\/script>')
</script>

<script src="/pyaellascripts/foundation/foundation.js"></script>
<script src="/pyaellascripts/foundation/foundation.alerts.js"></script>
<script src="/pyaellascripts/foundation/foundation.clearing.js"></script>
<script src="/pyaellascripts/foundation/foundation.cookie.js"></script>
<script src="/pyaellascripts/foundation/foundation.dropdown.js"></script>
<script src="/pyaellascripts/foundation/foundation.forms.js"></script>
<script src="/pyaellascripts/foundation/foundation.interchange.js"></script>
<script src="/pyaellascripts/foundation/foundation.joyride.js"></script>
<script src="/pyaellascripts/foundation/foundation.magellan.js"></script>
<script src="/pyaellascripts/foundation/foundation.orbit.js"></script>
<script src="/pyaellascripts/foundation/foundation.placeholder.js"></script>
<script src="/pyaellascripts/foundation/foundation.reveal.js"></script>
<script src="/pyaellascripts/foundation/foundation.section.js"></script>
<script src="/pyaellascripts/foundation/foundation.tooltips.js"></script>
<script src="/pyaellascripts/foundation/foundation.topbar.js"></script>

<script>
    $(document).foundation();
</script>
</body>
</html>
