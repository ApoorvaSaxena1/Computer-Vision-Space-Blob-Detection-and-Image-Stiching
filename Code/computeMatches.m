function m = computeMatches(f1,f2)

N=size(f1,1);
M=size(f2,1);
m=zeros(N,1);

for i=1:N
    temp=zeros(M,2);
    j_val=0;
    for j=1:M
        X = f1(i,:) - f2(j,:);
        temp(j,1) = sum(X(:).^2);
        temp(j,2)=j;
        j_val=j;
        
    end
    temp=sortrows(temp);
    a=temp(1,1);
    b=temp(2,1);
    if a/b<0.8
        m(i)=temp(1,2);
    else
        m(i)=0;
    end
end
