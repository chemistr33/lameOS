#define XYZ __attribute__((noinline))

XYZ
int addfive(int a, int b, int c, int d, int e)
    {return (a+b+c+d+e);}

int main()
{
    int v = 1;
    int w = 2;
    int x = 3;
    int y = 4;
    int z = 5;
    int ret;
    ret = addfive(v,w,x,y,z);
    return 77;
}





