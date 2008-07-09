////////////////////////////////////////////////////////////////////////////////
//
//  S2 Factory, Inc.
//  Copyright 2008 S2 Factory, Inc.
//  All Rights Reserved.
//
////////////////////////////////////////////////////////////////////////////////

var userAgent = navigator.userAgent;
var appName = navigator.appName;
var swfContainer = null;

function initializeMouseWheel()
{
	if (userAgent.indexOf('Mac') > -1)
	{
		swfContainer = document.getElementById(swfContainerId);
		
		if (swfContainer != null)
		{
			if (swfContainer.addEventListener)
				swfContainer.addEventListener('DOMMouseScroll', mouseWheelHandler, false);
			swfContainer.onmousewheel = mouseWheelHandler;
		}
	}
}

function mouseWheelHandler(event)
{
	var delta = 0;
	var mouseX;
	var mouseY;
	
	if (!event)
		event = window.event;
	
	if (event.detail)
		delta = -event.detail;
	else if (event.wheelDelta)
	{
		delta = event.wheelDelta;
		if (window.opera)
			delta = -delta;
	}
	
	if ((userAgent.indexOf('Firefox') > -1) || (userAgent.indexOf('Camino') > -1))
	{
		mouseX = event.layerX;
		mouseY = event.layerY;
	}
	else
	{
		mouseX = event.offsetX;
		mouseY = event.offsetY;
	}
		
	var movie = document.getElementById(swfId);
	if (movie.dispatchMouseWheelEvent)
		movie.dispatchMouseWheelEvent((delta >= 0) ? 1 : -1, mouseX, mouseY);
	
	if (event.preventDefault)
		event.preventDefault();
		
	event.returnValue = false;
}