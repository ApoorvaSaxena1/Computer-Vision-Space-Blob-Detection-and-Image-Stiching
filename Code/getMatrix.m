function mat = getMatrix(im,n,i,j)
% nrows=size(im,1);
% ncols=size(im,2);
% nlevels=size(im,3);



    
    

mat(:,:,1)=[im(i-1,j-1,n-1) im(i-1,j,n-1) im(i-1,j+1,n-1) ;
            im(i,j-1,n-1) im(i,j,n-1) im(i,j+1,n-1);
            im(i+1,j-1,n-1) im(i+1,j,n-1) im(i+1,j+1,n-1)];
mat(:,:,2)=[im(i-1,j-1,n) im(i-1,j,n) im(i,j,n);
            im(i,j-1,n) im(i,j,n) im(i,j,n);
            im(i+1,j-1,n) im(i+1,j,n) im(i,j,n)];
mat(:,:,3)=[im(i-1,j-1,n+1) im(i-1,j,n+1) im(i-1,j+1,n+1);
            im(i,j-1,n+1) im(i,j,n+1) im(i,j+1,n+1);
            im(i+1,j-1,n+1) im(i+1,j,n+1) im(i+1,j+1,n+1)];