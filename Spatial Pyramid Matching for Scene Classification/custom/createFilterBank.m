function [filterBank] = createFilterBank() 
% Code to generate reasonable filter bank

    gaussianScales = [1 2 4 8 sqrt(2)*8];
    logScales      = [1 2 4 8 sqrt(2)*8];
    dxScales       = [1 2 4 8 sqrt(2)*8];
    dyScales       = [1 2 4 8 sqrt(2)*8];
    directions = [0,pi/8,pi/4,pi*3/8,pi/2,pi*5/8,pi*3/4,pi*7/8];
    
    filterBank = cell(numel(gaussianScales) + numel(logScales) + numel(dxScales) + numel(dyScales)+numel(directions),1);

    idx = 0;

    for scale = gaussianScales
        idx = idx + 1;
        filterBank{idx} = fspecial('gaussian', 2*ceil(scale*2.5)+1, scale);
    end

    for scale = logScales
        idx = idx + 1;
        filterBank{idx} = fspecial('log', 2*ceil(scale*2.5)+1, scale);
    end

    for scale = dxScales
        idx = idx + 1;
        f = fspecial('gaussian', 2*ceil(scale*2.5) + 1, scale);
        f = imfilter(f, [-1 0 1], 'same');
        filterBank{idx} = f;
    end

    for scale = dyScales
        idx = idx + 1;
        f = fspecial('gaussian', 2*ceil(scale*2.5) + 1, scale);
        f = imfilter(f, [-1 0 1]', 'same');
        filterBank{idx} = f;
    end
    
    for d=directions
                p = ceil(3*2.5);
                xmax = max(abs(p*cos(d)),abs(p*sin(d)));
                ymax = max(abs(p*sin(d)),abs(p*cos(d)));
                xmin = -xmax;
                ymin = -ymax;
                [x,y] = meshgrid(xmin:xmax,ymin:ymax);
                x_r = x*cos(d)+y*sin(d);
                y_r = y*cos(d)-x*sin(d);
                idx = idx+1;
                filterBank{idx} = exp(-0.5*(x_r.^2+y_r.^2)/3^2).*cos(2*pi*2/(p*1.5)*x_r);
                idx = idx+1;
                filterBank{idx} = exp(-0.5*(x_r.^2+y_r.^2)/3^2).*sin(2*pi*2/(p*1.5)*x_r);
               
end
