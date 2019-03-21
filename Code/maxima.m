function res = maxima(im,vec)
I=reshape(im,1,[]);
if I(1,14)==max(I)
    res=I(1,14) ;
else
    res=0;
end