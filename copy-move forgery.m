imageSahte=imread('C:\Users\ben burak\Desktop\forged2.PNG');


for i=1:size(imageSahte,1)
     for j=1:size(imageSahte,2)
         Greyimage(i,j)=0.2989*imageSahte(i,j,1)+0.5870*imageSahte(i,j,2)+0.1140*imageSahte(i,j,3);
              
     end
end



GreyimageOrjinal=Greyimage(1:size(Greyimage,1),1:size(Greyimage,2));
GreyimageForgery=Greyimage(1:size(Greyimage,1),1:size(Greyimage,2));
GreyimageForgeryBlock=Greyimage(1:size(Greyimage,1),1:size(Greyimage,2));
MaskeGoruntu=Greyimage(1:size(Greyimage,1),1:size(Greyimage,2));

for i=1:size(MaskeGoruntu,1)
    for j=1:size(MaskeGoruntu,2)
        MaskeGoruntu(i,j)=0;
    end
end

% for i=1:20                                                                                    
%     for j=1:20
%         GreyimageForgery(i,j+5,:)=GreyimageForgery(i,j,:);
%     end
% end

% imshow(GreyimageForgery);

% 
% for i=1:20                                                                                      
%     for j=50:90
%         GreyimageForgery(i,j+16,:)=GreyimageForgery(i,j,:);
%     end
% end
% 
% for i=130:170                                                                            
%     for j=10:25
%         GreyimageForgery(i+20,j,:)=GreyimageForgery(i,j,:);
%     end
% end
% 
% for i=165:195          %baboon                                                                            
%     for j=80:100
%         GreyimageForgery(i,j+25,:)=GreyimageForgery(i,j,:);
%     end
% end



M=size(GreyimageForgery,1);                  
N=size(GreyimageForgery,2);

B=16;                                              

NrBins=256;    


a=1;
for i=1:M-B+1
    for j=1:N-B+1
%       Hist(a,:,:)=histogramfonk(Greyimage,i,i+B-1,j,j+B-1,NrBins);
          HistVector(a,:)=histogramfonk(GreyimageForgery,i,i+B-1,j,j+B-1,NrBins);
           a=a+1;
    end
end

 totalHistogram=(M-B+1)*(N-B+1);   
 
%  tic
% row=1;                                                                             
% for i=1:totalHistogram
%     h1=HistVector(i,:);
%     for j=i+1:totalHistogram
%         h2=HistVector(j,:);
%         
%         sonucdegeri=chiSquare(h1,h2);
%        
%         if sonucdegeri==0
%             uzaklik=abs(i-j);
%             KiKareVector(row,:)=[i j uzaklik];
%             row=row+1;
%         end
%         
%     end
% end
% toc

row=1;
for i=1:totalHistogram
    h1=HistVector(i,:);
    for j=i+1:totalHistogram
        h2=HistVector(j,:);
        
        sonucdegeri=intersection(h1,h2);
        
        if sonucdegeri==256
             uzaklik=abs(i-j);
            KiKareVector(row,:)=[i j uzaklik];
            row=row+1;
        end
        
    end
end

H=zeros(1,totalHistogram-1);
for i=1:size(KiKareVector,1)
    for j=i+1:size(KiKareVector,1)
            if  (abs(KiKareVector(i,1)-KiKareVector(j,1))==1 & abs(KiKareVector(i,2)-KiKareVector(j,2))==1) | (abs(KiKareVector(i,1)-KiKareVector(j,1))==M-B+1 & abs(KiKareVector(i,2)-KiKareVector(j,2))==M-B+1)             
                    H( abs(KiKareVector(i,1)-KiKareVector(i,2)))=H( abs(KiKareVector(i,1)-KiKareVector(i,2)))+1;            
            end               
    end
end


for i=1:size(KiKareVector,1)
    if H(i)>=1
        H(i)=H(i)+1;
    end
end

for i=1:size(KiKareVector,1)
        tut=KiKareVector(i,3);
        KiKareVector2(i,:)=[KiKareVector(i,1) KiKareVector(i,2) KiKareVector(i,3) H(tut)];
end

EsikDegeri=2;
for  i=1:size(KiKareVector,1)
    if KiKareVector2(i,4)>EsikDegeri
            KiKareVectorGuncel(i,:)=[KiKareVector2(i,1) KiKareVector2(i,2) KiKareVector2(i,3) KiKareVector2(i,4)];
    end
end
        

 for i=1:size(KiKareVectorGuncel,1)
   
     if KiKareVectorGuncel(i,1)<=M-B+1 & KiKareVectorGuncel(i,2)<=N-B+1
               for k=1:B
                   for m=KiKareVectorGuncel(i,1):KiKareVectorGuncel(i,1)+B-1
                       GreyimageForgeryBlock(k,m)=255;
                       MaskeGoruntu(k,m)=255;
                   end
               end         
               for n=1:B
                   for p=KiKareVectorGuncel(i,2):KiKareVectorGuncel(i,2)+B-1
                       GreyimageForgeryBlock(n,p)=255;
                       MaskeGoruntu(n,p)=255;
                   end
               end
     end
      
     if KiKareVectorGuncel(i,1)<=M-B+1 & KiKareVectorGuncel(i,2)>N-B+1
        
         satir2B=fix(KiKareVectorGuncel(i,2)/(M-B+1))+1;    %1.
         sutun2B=mod(KiKareVectorGuncel(i,2),M-B+1);
         if sutun2B==0        %sonradan ekledim deðiþebilme ihtimali var.
             sutun2B=1;
         end
         
         for satir1=1:B
             for sutun1=KiKareVectorGuncel(i,1):KiKareVectorGuncel(i,1)+B-1
                 GreyimageForgeryBlock(satir1,sutun1)=255;
                 MaskeGoruntu(satir1,sutun1)=255;
             end
         end
         for satir2=satir2B:satir2B+B-1
             for sutun2=sutun2B:sutun2B+B-1
                 GreyimageForgeryBlock(satir2,sutun2)=255;
                 MaskeGoruntu(satir2,sutun2)=255;
             end
         end
     end
     
      if KiKareVectorGuncel(i,1)>M-B+1 & KiKareVectorGuncel(i,2)>N-B+1
            satir1B=fix(KiKareVectorGuncel(i,1)/(M-B+1))+1; %2.
            sutun1B=mod(KiKareVectorGuncel(i,1),M-B+1);
             if sutun1B==0        %sonradan ekledim deðiþebilme ihtimali var.
             sutun1B=1;
            end
            
            satir2B=fix(KiKareVectorGuncel(i,2)/(M-B+1))+1; %3.
            sutun2B=mod(KiKareVectorGuncel(i,2),M-B+1);
             if sutun2B==0        %sonradan ekledim deðiþebilme ihtimali var.
             sutun2B=1;
             end
            
             for satir1=satir1B:satir1B+B-1
                for sutun1=sutun1B:sutun1B+B-1
                     GreyimageForgeryBlock(satir1,sutun1)=255;
                     MaskeGoruntu(satir1,sutun1)=255;
                end
             end
              for satir2=satir2B:satir2B+B-1
                for sutun2=sutun2B:sutun2B+B-1
                     GreyimageForgeryBlock(satir2,sutun2)=255;
                     MaskeGoruntu(satir2,sutun2)=255;
                end
             end
      end      
 end
 
 
 imwrite(MaskeGoruntu,'C:\Users\ben burak\Desktop\kýzMaskeGoruntu.PNG');
 

subplot(1,3,1)
imshow(GreyimageOrjinal);
title('Orjinal Görüntü');
subplot(1,3,2)
imshow(GreyimageForgery);
title('Sahte Görüntü');
subplot(1,3,3)
imshow(GreyimageForgeryBlock);
title('Sahte Kýsýmlar');       




%imwrite(GreyimageForgeryBlock,'C:\Users\ben burak\Desktop\LenaOrjSahteKýsýmlar.JPG');
   
  
    
    
    
    


