function [y] = plotMyLine(a,b,c)
    x = [-100:100];
    y = a*x+b;
    lineColor = string(c);
    figure
    plot(x,y, lineColor)
    xlabel('X'); ylabel('Y');
    title('Y as a Function of X');
end