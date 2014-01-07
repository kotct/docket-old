function docket_collapse_toggle(day_tag)
{
	var panel = document.getElementById("docket-collapsing-day-panel-" + day_tag);
	var icon = panel.getElementsByClassName("docket-collapsing-indicator-image")[0];
	var body = panel.getElementsByClassName("docket-collapsing-div-data")[0];

	var collapsed = panel.getAttribute("docket-is-collapsed") == "true" ? true : false;
	var icon_future_class_name = collapsed ? "glyphicon-chevron-up" : "glyphicon-chevron-down";

	var icon_classes = icon.className.split(" ");
	var new_icon_classes = [];

	icon_classes.map(function(cls)
	{
		var match = cls.match(/glyphicon-chevron-(up|down)/g);

		/* Stop errors */
		if(match == null || match == undefined) {
			new_icon_classes.push(cls);

			return;
		}

		if(match.length > 0) {
			new_icon_classes.push(icon_future_class_name);

			return;
		}
	});

	icon.className = new_icon_classes.join(" ");

	if(collapsed) {
		panel.setAttribute("docket-is-collapsed", "false");
		body.style.display = "inherit";
	} else {
		panel.setAttribute("docket-is-collapsed", "true");
		body.style.display = "none";
	}
}
