Marked Style: EdMath
XHTML Header: <script src="wikiscript.js"></script>

Marked setup
============

Custom styles
-------------
* Add EdMath as a Custom Style in Marked Preferences Style

* To use that style put  this at the very start of the markdown file

	~~~yaml
	Marked Style: EdMath
	~~~


Wikipedia preprocessor
----------------------

To have a link looked up in Wikipedia automagically:

* Symbolically link the javascript file `wikiscript.js` to the same directory as the markdown file

* Add this to the start of the markdown file

		XHTML Header: <script src="wikiscript.js"></script>

* Use `[Wiki page name](!)` to invoke it. e.g. `[markdown](!)` displays as [markdown](!).  Page naming follows the [Wikipedia:Naming conventions](!)

	* spaces will be converted to underscores
	* the first letter will be capitalised

* If you want a different link to the name you want to highlight then add it after the ! in brackets e.g. `[markup](!markdown)` will display as [markup](!markdown) but link to the Wiki markdown page.


