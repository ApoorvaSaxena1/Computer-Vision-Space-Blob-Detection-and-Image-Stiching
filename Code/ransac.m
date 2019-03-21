function [inliers, transf] = ransac(matches, c1, c2, method)
% This code is part of:
%
%   CMPSCI 670: Computer Vision
%   University of Massachusetts, Amherst
%   Instructor: Subhransu Maji

len=size(matches,1);
vecs=[];

% Removing matches with j index as 0

for i=1:len
    if matches(i,2)~=0
        vecs=[vecs ; c1(i,1) c1(i,2) c2(i,1) c2(i,2)];
    end
end

len2=size(vecs,1);
transf_mat=zeros(20,6);

% Developing models for affine transformation featues

for i=1:20
    
    test=randi(len2,1,3);
    A=[vecs(test(1),1) vecs(test(1),2) 0 0 1 0;
        0 0 vecs(test(1),1) vecs(test(1),2) 0 1;
        vecs(test(2),1) vecs(test(2),2) 0 0 1 0;
        0 0 vecs(test(2),1) vecs(test(2),2) 0 1;
        vecs(test(3),1) vecs(test(3),2) 0 0 1 0;
        0 0 vecs(test(3),1) vecs(test(3),2) 0 1];
    B=[vecs(test(1),3);
        vecs(test(1),4);
        vecs(test(2),3);
        vecs(test(2),4);
        vecs(test(3),3);
        vecs(test(3),4)];
    X = linsolve(A,B);
    transf_mat(i)=X';
    
end

% Finding best model

sums=zeros(1,20);
for i=1:20
    sum_temp=0;
    for j=1:len2
        A=[vecs(j,1) vecs(j,2) 0 0 1 0;
        0 0 vecs(j,1) vecs(j,2) 0 1];
        B=[vecs(j,3);vecs(j,4)];
        
        sum_temp=sum_temp+sum(B-A.(transf_mat(i))');
        
    end
  sums(i)=sum_temp;
end

% Determining inliers

[M I]=min(sums);
inliers=[];
transf=transf_mat(I,:);
for i=1:len2
     A=[vecs(i,1) vecs(i,2) 0 0 1 0;
        0 0 vecs(i,1) vecs(i,2) 0 1];
        B=[vecs(i,3);vecs(i,4)];
        
        if sum(B-A.(transf)')<0.1
            inliers=[inliers;vecs(i,:)];
        end
    
end
temp=[transf(1,1) transf(2,1) transf(5,1);
    transf(3,1) transf(4,1) transf(6,1) ];
transf=temp;

