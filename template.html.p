<!DOCTYPE html>
<html lang="en">

◊(require racket/list)

◊(define title (or (select-from-metas 'title metas) "page"))
◊(define stylesheets (or (select-from-metas 'stylesheets metas) empty))

<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="icon" href="/favicon.svg" type="image/svg+xml">
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link
		href="https://fonts.googleapis.com/css2?family=Atkinson+Hyperlegible+Mono:ital,wght@0,200..800;1,200..800&family=Atkinson+Hyperlegible+Next:ital,wght@0,200..800;1,200..800&display=swap"
		rel="stylesheet">
	<link rel="stylesheet" href="/common.css">
	◊(map (lambda (stylesheet) ◊string-append{
	<link rel="stylesheet" href="◊|stylesheet|">
	}) stylesheets)
	<title>◊(select-from-metas 'title metas) - text to types</title>
</head>

<body>
	<header>
		<h1 class="title">
			<a href="/">
				<span class="logo">&lt;T&gt;</span>
				<span class="text">text</span>
				<span class="text">to</span>
				<span class="text">types</span>
			</a>
		</h1>
		<nav>
			<!-- TODO: maybe use a details element to make this collapsible for mobile? -->
			<ul>
				<li><a href="/">home</a></li>
				<li><a href="https://research.texttotypes.com">blog</a></li>
				<li><a href="/portfolio">portfolio</a></li>
				<li><a href="/resume">resume</a></li>
				<li><a href="https://github.com/pixilcode">github</a></li>
			</ul>
		</nav>
	</header>

	<main>
		◊(->html doc #:splice #t)
	</main>

	<footer>
	    <p>
	        &copy; 2025 Brendon Bown.
        </p>
        <p>
            Built with
		    <a href="https://docs.racket-lang.org/pollen/">Pollen</a>.
		</p>
		<p>
		    Source code on
			<a href="https://github.com/pixilcode/texttotypes.com">Github</a>.
		</p>
    </footer>
</body>

</html>
