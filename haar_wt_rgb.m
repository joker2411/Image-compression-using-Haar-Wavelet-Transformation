function haar_wt_rgb(image_name,delta)

if nargin > 2
    error('harr_wt:TooManyInputs', ...
        'requires at most 1 optional inputs');
end

%Set the default value of 'delta' to 0.01
if (nargin==1)
    delta=0.01;
end

if (delta>1 || delta<0)
    error('harr_wt: Delta must be a value between 0 and 1');
end
rgb=double(imread(image_name));
len=length(size(rgb));

if len~=3
    error('harr_wt_rgb: Input image must be a RGB image, use "haar_wt" function to compress Grey Images');
end
r=rgb(:,:,1);
g=rgb(:,:,2);
b=rgb(:,:,3);

%Compress each layer separately
r=hwt(r,delta);
g=hwt(g,delta);
b=hwt(b,delta);

rgb(:,:,1)=r;
rgb(:,:,2)=g;
rgb(:,:,3)=b;

imwrite(rgb/255,'compressed_rgb.jpg')

