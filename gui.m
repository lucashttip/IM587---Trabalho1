## 20.03.2017 Andreas Weber <andy@josoansi.de>
## Demo which has the aim to show all available GUI elements.
## Useful since Octave 4.0


clear all
clc


Mecanismo

close all

graphics_toolkit qt

figure("position", [300 150 800 800])
h.ax = axes ("position", [0.05 0.2 0.9 0.7]);

h.fcn = @(q0rad,A0,B0) newtonR2(Ff,iJf,q0rad,A0,B0,1e-5,15);

q0 = -6.5;


function update_plot (obj, init = false)

  ## gcbo holds the handle of the control
  h = guidata (obj);
  recalc = false;
  switch (gcbo)
    case {h.noise_slider}
      recalc = true;
  endswitch

  if (recalc || init)
    q0 = get (h.noise_slider, "value");
    
    set (h.noise_label, "string", sprintf ("q: %.1f º", q0 ));
    
    q0rad = deg2rad(q0);
    
    [a,b] = h.fcn (q0rad,pi,0) ;
    
    [x,y] = desenha(q0rad,a,b);
    
    if (init)
      
      h.plot = patch(x,y,[0.8,0.8,0.8]);
      xlim([-50,40]);
      ylim([-10,80]);
      guidata (obj, h);
    else
      set (h.plot, "ydata", y,"xdata",x);
    endif
  endif
  
endfunction


## noise
h.noise_label = uicontrol ("style", "text",
                           "units", "normalized",
                           "string", "q0:",
                           "horizontalalignment", "left",
                           "position", [0.05 0.1 0.35 0.05]);

h.noise_slider = uicontrol ("style", "slider",
                            "units", "normalized",
                            "string", "slider",
                            "callback", @update_plot,
                            "min",-6.5,
                            "max",0.4,
                            "value", -6.5,
                            "position", [0.05 0.02 0.8 0.06]);

set (gcf, "color", get(0, "defaultuicontrolbackgroundcolor"))
guidata (gcf, h)
update_plot (gcf, true);