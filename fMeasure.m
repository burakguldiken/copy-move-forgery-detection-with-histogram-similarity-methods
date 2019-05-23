
imageSahte=imread('C:\Users\ben burak\Desktop\forged2_maske.PNG');


imageSahte2=imread('C:\Users\ben burak\Desktop\kýzMaskeGoruntu.PNG');

 imshow(imageSahte2);

dp=0;
yp=0;
yn=0;
for i=1:size(imageSahte,1)
    for j=1:size(imageSahte,1)
            if imageSahte(i,j)==0 & imageSahte2(i,j)==255
                yp=yp+1;
            end
            if imageSahte(i,j)==255 & imageSahte2(i,j)==255
                dp=dp+1;
            end
            if imageSahte(i,j)==255 & imageSahte2(i,j)==0
                yn=yn+1;
            end
    end
end

disp(yp);
disp(dp);
disp(yn);

k=dp/(dp+yp);
d=dp/(dp+yn);
f1=2*(k*d)/(k+d);
disp(f1);

