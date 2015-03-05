function c = haarTransform2(c)

f = c;
[m n] = size(c);

k = n / 2;

for i=1:1:m
	for j=1:1:k
		f(i, j) = c(i, 2*j) + c(i, 2*j-1);
		f(i, j+k) = c(i, 2*j) - c(i, 2*j-1);
	end
end

c = f;
k = m / 2;

for j=1:1:m
	for i=1:1:k
		c(i, j) = (f(2*i, j) + f(2*i-1, j)) / 2;
		c(i+k, j) = (f(2*i, j) - f(2*i-1, j)) / 2;
	end
end

end