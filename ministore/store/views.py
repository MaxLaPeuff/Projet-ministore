from django.shortcuts import render,get_object_or_404,redirect
from .models import Category , Product,CreateBlog,Commande
from .forms import BlogForm
from django.views.generic import ListView

# Create your views here.

def home (request):
     return render (request,'store/index.html')
 
def shop(request):
    categories = Category.objects.all()
    content = {
        'categories': categories
    }
    return render(request, 'store/shop.html', content)


def infos(request,myid):
     products=Product.objects.get(id=myid)
     return render(request,'store/infos.html', {'products':products})

def checkout(request):
    if request.method=="POST":
        items=request.POST.get('items')
        nom=request.POST.get('nom')
        email=request.POST.get('email')
        phone=request.POST.get('phone')
        pays=request.POST.get('pays')
        address=request.POST.get('address')
        total=request.POST.get('total')
        com=Commande(items=items,nom=nom,email=email,phone=phone,pays=pays,address=address)
        com.save()
        
    return render (request, 'store/checkout.html')

class List(ListView):
    template_name = 'store/blog.html'
    queryset = CreateBlog.objects.all()
    paginate_by = 2

def detailView(request,slug):
    post=CreateBlog.objects.get(slug=slug)
    comments=post.comments.all()
    if request.method=='POST':
        form=BlogForm(request.POST)
        if form.is_valid():
            form.save(commit=False)
            form.instance.post=post
            form.save()
            return redirect('detailView',slug=post.slug)
    else:
        form=BlogForm
    content={
        'article':post,
        'comments':comments,
        'form':form,
    }
    return render(request,'store/update.html',content)

