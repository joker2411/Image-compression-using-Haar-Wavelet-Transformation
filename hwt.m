function z=hwt(a,delta)

%H1, H2, H3 are the transformation matrices for Haar wavelet Transform
H1=[0.5 0 0 0 0.5 0 0 0;0.5 0 0 0 -0.5 0 0 0;0 0.5 0 0 0 0.5 0 0 ;0 0.5 0 0 0 -0.5 0 0 ;0 0 0.5 0 0 0 0.5 0;0 0 0.5 0 0 0 -0.5 0;0 0 0 0.5 0 0 0 0.5;0 0 0 0.5 0 0 0 -0.5;];
H2=[0.5 0 0.5 0 0 0 0 0;0.5 0 -0.5 0 0 0 0 0;0 0.5 0 0.5 0 0 0 0;0 0.5 0 -0.5 0 0 0 0;0 0 0 0 1 0 0 0;0 0 0 0 0 1 0 0;0 0 0 0 0 0 1 0;0 0 0 0 0 0 0 1;];
H3=[0.5 0.5 0 0 0 0 0 0;0.5 -0.5 0 0 0 0 0 0;0 0 1 0 0 0 0 0;0 0 0 1 0 0 0 0;0 0 0 0 1 0 0 0;0 0 0 0 0 1 0 0;0 0 0 0 0 0 1 0;0 0 0 0 0 0 0 1;];

%Normalize each column of H1,H2,H3 to a length 1(This results in orthonormal columns of each matrix)
H1=normc(H1);
H2=normc(H2);
H3=normc(H3);

H=H1*H2*H3; %Resultant transformation matrix
x=a;

y=zeros(size(x));

[r,c]=size(x);
%Above 8x8 transformation matrix(H) is multiplied by each 8x8 block in the image

for i=0:8:r-8
    for j=0:8:c-8
        p=i+1;
        q=j+1;
        y(p:p+7,q:q+7)=(H')*x(p:p+7,q:q+7)*H;
    end
end

%compression ratio depends on the delta value you select
%Larger the value 'delta', compression ratio will be larger
%delta=0.01;

n1=nnz(y);                          % Number of non-zero elements in 'y'

z=y;
m=max(max(y));
y=y/m;
y(abs(y)<delta)=0;                  % Values within +delta and -delta in 'y' are replaced by zeros(This is the command that result in compression)
y=y*m;
n2=nnz(y);                          % Number of non-zero elements in updated 'y'

%Inverse DWT of the image

for i=0:8:r-8
    for j=0:8:c-8
        p=i+1;
        q=j+1;
        z(p:p+7,q:q+7)=H*y(p:p+7,q:q+7)*H';
    end
end

% Below value is a measure of compression ratio, not the exact ratio
%compression_ratio=n1/n2