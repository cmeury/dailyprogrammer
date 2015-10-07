import std.stdio;
import std.file;
import std.conv;
import std.string;
import std.array;
import std.uni;
import std.math;
import std.algorithm;

void main()
{
	string input_file_name = "input.txt";
	File file = File(input_file_name, "r");
	scope(exit) file.close();
	int size = to!int(chomp(file.readln()));
	writefln("Parsing %d numbers from %s", size, input_file_name);
	for(int i = 0; i < size; i++) {
		string line = chomp(file.readln());
		line = removechars(line, "()");
		line = stripLeft(stripRight(line));
		auto numbers = split(line, ",");
		int a = to!int(numbers[0]);
		int b = to!int(numbers[1]);
		
		string validity;
		if(ruth_aaron(a, b)) {
			validity = "VALID";
		} else {
			validity = "NOT VALID";
		}
		writefln("(%d-%d) %s", a, b, validity);
	}
}

pure bool ruth_aaron(int a, int b) {
	int[] fa = factors(a);
	int[] fb = factors(b);
	int sum_fa = unique_sum(fa);
	int sum_fb = unique_sum(fb);
	return sum_fa == sum_fb;
}

pure int unique_sum(int[] ary) {
	int sum = 0;
	foreach(int n; uniq(ary)) {
		sum += n;
	}
	return sum;
}

pure int[] factors(int n) {
	if(n < 2) {
		return [];
	}
	int[] factors;
	foreach(int p; prime_sieve(to!int(pow(n, 0.5)) + 1)) {
		if(p*p > n) {
		       break;
		}
		while(n % p == 0) {
			factors ~= p;
			n = n / p;
		}
	}
	if(n > 1) {
		factors ~= n;
	}
	return factors;
}

pure int[] prime_sieve(int n) {
	bool[] prime;
	prime.length = n+2;
	prime[2 .. n] = true;
	for(int i = 2; i <= sqrt(to!float(n)); i++) {
		if(prime[i]) {
			int ii = i*i;
			for(int j = 0; ( ii + (j*i) ) <= n; j++) {
			       prime[ ii + (j*i) ] = false;
			}
		}
	}
	int[] primes;
	for(int i = 2; i <= n; i++) {
		if(prime[i]) {
			primes ~= i;
		}
	}
	return primes;	
}
