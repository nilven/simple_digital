using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.Time.Gregorian as Calendar;
using Toybox.ActivityMonitor as ActivityMonitor;


class Simple_Digital_FaceView extends Ui.WatchFace {

    //! Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    //! Called when this View is brought to the foreground. Restore
    //! the state of this View and prepare it to be shown. This includes
    //! loading resources into memory.
    function onShow() {
    }

    //! Update the view
    function onUpdate(dc) {
       // Get and show the current weekday and time
		var info = Calendar.info(Time.now(), Time.FORMAT_MEDIUM);
		var dateString = Lang.format("$1$ $2$ $3$", [info.day_of_week, info.day, info.month]);
		var viewdate = View.findDrawableById("DateLabel");
		viewdate.setText(dateString);
        // Get and show the current time
        var clockTime = Sys.getClockTime();
    	var settings=Sys.getDeviceSettings();
        var timeString;
        var timeExtString;
       		if(settings.is24Hour) {
        		timeString = Lang.format("$1$:$2$", [clockTime.hour, clockTime.min.format("%02d")]);
        		var view = View.findDrawableById("TimeLabel");
        		view.setText(timeString);
        	 	}
        	else {
				var hour = 1+ (clockTime.hour + 11) % 12;
				var ampm = (clockTime.hour>11) ? "pm" : "am";
				timeString = Lang.format("$1$:$2$", [hour, clockTime.min.format("%02d")]);
        		timeExtString = Lang.format("$1$",[ampm]);
        		var view = View.findDrawableById("TimeLabel");
        		view.setText(timeString);
                var view2 = View.findDrawableById("TimeExtLabel");
                view2.setText(timeExtString);
                }
        
      	
        		
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
      
        
// // Battery Status Bar \\ \\		
		// Get the current Battery percentage
		var batStat = Sys.getSystemStats().battery;	
		// Change to percentage width
		var batBar = (dc.getWidth()/100)*batStat;  
		// draw in exchange with battery status
		if (batStat<=10)
		{ 
				dc.setColor(Gfx.COLOR_DK_RED,Gfx.COLOR_WHITE);
				dc.drawRectangle(0,0,batBar,3);
				dc.fillRectangle(0,0,batBar,3);
		}
		else if (batStat <=20)
		{ 
				dc.setColor(Gfx.COLOR_RED,Gfx.COLOR_WHITE);
				dc.drawRectangle(0,0,batBar,3);
				dc.fillRectangle(0,0,batBar,3);
		}
		else if (batStat <=30)
		{ 
				dc.setColor(Gfx.COLOR_ORANGE,Gfx.COLOR_WHITE);
				dc.drawRectangle(0,0,batBar,3);
				dc.fillRectangle(0,0,batBar,3);
		}
		else if (batStat <=40)
		{ 
				dc.setColor(Gfx.COLOR_YELLOW,Gfx.COLOR_WHITE);
				dc.drawRectangle(0,0,batBar,3);
				dc.fillRectangle(0,0,batBar,3);
		}
		else if (batStat <=50)
		{ 
				dc.setColor(Gfx.COLOR_GREEN,Gfx.COLOR_WHITE);
				dc.drawRectangle(0,0,batBar,3);
				dc.fillRectangle(0,0,batBar,3);
		}
		else
		{
    			dc.setColor(Gfx.COLOR_DK_GREEN,Gfx.COLOR_WHITE);
				dc.drawRectangle(0,0,batBar,3);
				dc.fillRectangle(0,0,batBar,3);
		}
		
// // Activity Status Bar \\ \\
    	// Get the current activity stats
		var activity = ActivityMonitor.getInfo();
		var actStat = (activity.steps*100)/activity.stepGoal;
		var actBar = (dc.getWidth()/100)*actStat;  
		var ActPosY = (dc.getHeight()-3);
		//set color for second bar and draw it
		    	
    	if (actStat<30)
		{ 
				dc.setColor(Gfx.COLOR_DK_RED,Gfx.COLOR_WHITE);
				dc.drawRectangle(0,ActPosY,actBar,3);
				dc.fillRectangle(0,ActPosY,actBar,3);
		}
		else if (actStat <=45)
		{ 
				dc.setColor(Gfx.COLOR_RED,Gfx.COLOR_WHITE);
				dc.drawRectangle(0,ActPosY,actBar,3);
				dc.fillRectangle(0,ActPosY,actBar,3);
		}
		else if (actStat <=60)
		{ 
				dc.setColor(Gfx.COLOR_ORANGE,Gfx.COLOR_WHITE);
				dc.drawRectangle(0,ActPosY,actBar,3);
				dc.fillRectangle(0,ActPosY,actBar,3);
		}
		else if (actStat <=75)
		{ 
				dc.setColor(Gfx.COLOR_YELLOW,Gfx.COLOR_WHITE);
				dc.drawRectangle(0,ActPosY,actBar,3);
				dc.fillRectangle(0,ActPosY,actBar,3);
		}
		else if (actStat <=90)
		{ 
				dc.setColor(Gfx.COLOR_GREEN,Gfx.COLOR_WHITE);
				dc.drawRectangle(0,ActPosY,actBar,3);
				dc.fillRectangle(0,ActPosY,actBar,3);
		}
		else if (actStat <=100)
		{
    			dc.setColor(Gfx.COLOR_DK_GREEN,Gfx.COLOR_WHITE);
				dc.drawRectangle(0,ActPosY,actBar,3);
				dc.fillRectangle(0,ActPosY,actBar,3);
		}
		else 
		{
    			dc.setColor(Gfx.COLOR_DK_GREEN,Gfx.COLOR_WHITE);
				dc.drawRectangle(0,ActPosY,dc.getWidth(),3);
				dc.fillRectangle(0,ActPosY,dc.getWidth(),3);
		}
		
    }

    //! Called when this View is removed from the screen. Save the
    //! state of this View here. This includes freeing resources from
    //! memory.
    function onHide() {
    }

    //! The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() {
    }

    //! Terminate any active timers and prepare for slow updates.
    function onEnterSleep() {
    }

}
