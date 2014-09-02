@arr = qw(1 2 3 4 1 1 5);
@arr = uniq sort (@arr);
print "@arr";
