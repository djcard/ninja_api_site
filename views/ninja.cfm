<style>
	td { text-align: center}
	.level1{ background-color: yellow; color:black}
	.level2{ background-color: blue; color:white}
	.level3{ background-color: green; color:white}
	.level4{ background-color: purple; color:white}
	.level5{ background-color: gold; color:white}
	.level6{ background-color: orange; color:white}
</style>

<cfoutput>
	<div class="container">
	<h1>Skill Levels as of #dateformat(now(),"mmmm dd, yyyy")#</h1>
		#prc.tableTemplate.run( tableData = prc.studentData, bordered=true )#
	</div>
</cfoutput>



<script>
	function onLoad() {
		for (var x = 0; x < document.styleSheets.length; x = x + 1) {
			if (document.styleSheets[x].href==="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css") {
				for(var y = 0; y< document.styleSheets[x].cssRules.length; y=y+1){
					if(document.styleSheets[x].cssRules[y].selectorText===".table > :not(caption) > * > *"){
						document.styleSheets[x].deleteRule(y);
					}
				}
			}
		}
	}
</script>