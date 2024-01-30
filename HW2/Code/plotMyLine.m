function [myPlot] = plotMyLine(a,b,c)
    x = -100:100;
    y = a*x+b;
    lineColor = string(c);
    plot(x,y, lineColor)
    xlabel('X'); ylabel('Y');
    title('Y as a Function of X');
end