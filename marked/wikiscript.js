	$('a[href^="!"]').each(function(index) {
		var t0 = $(this).text();
		var hr = $(this).attr("href");
		var t;
		if (hr === "!") {
			var t1 = t0.replace(/ /g, '_');
			t = t1.charAt(0).toUpperCase() + t1.slice(1);
		}
		else if (hr === "!#") {
			var t1 = t0.replace(/ /g, '');
			t = t1.toLowerCase();
			$(this).replaceWith('<a href="#mksection-' + t + '">' + t0 + '</a>');
			return;
		}
		else {
			t = hr.slice(1);
		}
		var t2 = t.replace(/’/g, "%27");
		$(this).replaceWith('<a href="https://en.wikipedia.org/wiki/' + t2 + '">' + t0 + '</a>');
	});
