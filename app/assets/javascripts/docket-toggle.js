function docket_collapse_toggle(day_tag)
{
	var panel = document.getElementById("docket-collapsing-day-panel-" + day_tag);
	var icon = panel.getElementsByClassName("docket-collapsing-indicator-image")[0];

	var icon_class_string = icon.className;
	var new_icon_class_string = "";

	var body = panel.getElementsByClassName("docket-collapsing-div-data")[0];

	var collapsed = panel.getAttribute("docket-is-collapsed") == "true" ? true : false;

	if(collapsed) {
		panel.setAttribute("docket-is-collapsed", "false");

		new_icon_class_string = icon_class_string.replace("glyphicon-chevron-down", "glyphicon-chevron-up");

		icon.className = new_icon_class_string;
		body.style.display = "inherit";
	} else {
		panel.setAttribute("docket-is-collapsed", "true");

		new_icon_class_string = icon_class_string.replace("glyphicon-chevron-up", "glyphicon-chevron-down");

		icon.className = new_icon_class_string;
		body.style.display = "none";
	}
}
