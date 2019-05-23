function [Hist]=histogramfonk(Greyimage,bolgeBasX,bolgeSonX,bolgeBasY,bolgeSonY,NrBins)


for i=1:NrBins
    Hist(i)=0;
end


n=0;
for i=bolgeBasX:bolgeSonX
    for j=bolgeBasY:bolgeSonY
        n=Greyimage(i,j);
%         if n==0
%             n=n+1;
%         end
       % Hist(n)=Hist(n)+1;
        Hist(n+1)=Hist(n+1)+1;
        n=0;
    end
end




