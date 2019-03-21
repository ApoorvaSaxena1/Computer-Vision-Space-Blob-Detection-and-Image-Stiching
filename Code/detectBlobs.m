function blobs = detectBlobs(im, param)
% This code is part of:
%
%   CMPSCI 670: Computer Vision
%   University of Massachusetts, Amherst
%   Instructor: Subhransu Maji

% Input:
%   IM - input image
%
% Ouput:
%   BLOBS - n x 4 array with blob in each row in (x, y, radius, score)
%
% Dummy - returns a blob at the center of the image
% blobs = round([size(im,2)*0.5 size(im,1)*0.5 0.25*min(size(im,1), size(im,2)) 1]);
scale_space = zeros(size(im,1),size(im,2),7);
imDouble = im2double(im);
rgbIM=rgb2gray(imDouble);

 k= 1.1;
 sigma=2.5;
 scales=[sigma  sigma*power(k,1) sigma*power(k,2) sigma*power(k,3) sigma*power(k,4) sigma*power(k,5) sigma*power(k,6) sigma*power(k,7) sigma*power(k,8) sigma*power(k,9) sigma*power(k,10) sigma*power(k,11) sigma*power(k,12) sigma*power(k,13) sigma*power(k,14)];
 for i=1:7
     
    sigma=scales(i);
    filt_size =  2*ceil(3*sigma)+1;
    LoG       =  sigma^2 * fspecial('log', filt_size, sigma);
    imFiltered = imfilter(rgbIM, LoG, 'same', 'replicate');
    scale_space(:,:,i)=imFiltered;
     
 end
max_scale_space=zeros(size(scale_space));
ncols=size(scale_space,2);
nrows=size(scale_space,1);
nlevels=size(scale_space,3);
for i=1:nlevels
    max_scale_space(:,:,i)=ordfilt2(scale_space(:,:,i),9,ones(3,3));
end

vals=[];
for k=1:nlevels
    for i = 1:nrows
        for j = 1:ncols  
            if k==1
                if scale_space(i,j,k)>= max([max_scale_space(i,j,2) max_scale_space(i,j,1)])
                    if scale_space(i,j,k)>0.001
                        d=[power(scale_space(i,j,k),2) i j sqrt(2)*scales(k)];
                        vals=[vals;d];
                    end
                end
                    
                
            elseif k==nlevels
                if scale_space(i,j,k)>= max([max_scale_space(i,j,nlevels) max_scale_space(i,j,nlevels-1)])
                    if scale_space(i,j,k)>0.001
                        d=[power(scale_space(i,j,k),2) i j sqrt(2)*scales(k)];
                        vals=[vals;d];
                    end
                end
                
            else
                if scale_space(i,j,k)>= max([max_scale_space(i,j,k+1) max_scale_space(i,j,k-1) max_scale_space(i,j,k)])
                    if scale_space(i,j,k)>0.001
                        d=[power(scale_space(i,j,k),2) i j sqrt(2)*scales(k)];
                        vals=[vals;d];
                    end
                end
            
            end

        end
    end
end

vals=sortrows(vals,-1);

blobs=zeros(size(vals));
blobs(:,4)=vals(:,1);
blobs(:,3)=vals(:,4);
blobs(:,1)=vals(:,3);
blobs(:,2)=vals(:,2);
