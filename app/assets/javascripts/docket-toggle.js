function docket_collapse_toggle(day_tag)
{
	var panel = document.getElementById("docket-collapsing-day-panel-" + day_tag);
	var icon = panel.getElementsByClassName("docket-collapsing-indicator-image")[0];
	var body = panel.getElementsByClassName("docket-collapsing-div-data")[0];

	var collapsed = panel.getAttribute("docket-is-collapsed") == "true" ? true : false;

	if(collapsed) {
		panel.setAttribute("docket-is-collapsed", "false");

		icon.className = "docket-collapsing-indicator-image glyphicon glyphicon-chevron-up";
		body.style.display = "inherit";
	} else {
		panel.setAttribute("docket-is-collapsed", "true");

		icon.className = "docket-collapsing-indicator-image glyphicon glyphicon-chevron-down";
		body.style.display = "none";
	}
}
