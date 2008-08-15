#include <iostream>
#include "srvSrc/IMobileSoap12Binding.nsmap"
#include "soapIMobileSoap12BindingObject.h"

#include "servicesImpl.h"
using namespace std;
int main (int argc, char * const argv[]) 
{
IMobileSoap12BindingService srv;
int m;
	try
	{
		testBuildCategs();
		m=srv.bind("localhost",8080,1);
		if(m >= 0)
		{
			for(int i=0;srv.accept() >= 0;i++)
			{
				srv.serve();
			}
		}
	}
	catch(string &str)
	{
		cout<<str<<endl;
	}
    return 0;
}
