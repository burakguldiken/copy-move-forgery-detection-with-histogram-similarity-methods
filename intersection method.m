function sum =intersection ( h1 , h2 )

sum=0;
for i=1:256
    sum=sum+(min(h1(i),h2(i)));
end

end