from django.shortcuts import render,get_object_or_404,redirect
from .models import Category,Product,CreateBlog,Commande
from .forms import BlogForm
from django.views.generic import ListView
from django.db.models import Prefetch

# Create your views here.

def home(request):
    return render(request, 'store/index.html')
 
def shop(request):
    # Récupérer toutes les catégories et les produits
    categories = Category.objects.all()
    products = Product.objects.all()
    
    # Créer un dictionnaire pour organiser les produits par catégorie
    category_products = {}
    for category in categories:
        category_products[category] = products.filter(category=category)
    
    content = {
        'categories': categories,
        'category_products': category_products
    }
    return render(request, 'store/shop.html', content)

def infos(request, myid):
    product = Product.objects.get(id=myid)
    # Récupérer les produits de la même catégorie, excluant le produit actuel
    related_products = Product.objects.filter(category=product.category).exclude(id=myid)[:4]
    return render(request, 'store/infos.html', {'product': product, 'related_products': related_products})

def checkout(request):
    if request.method == "POST":
        items = request.POST.get('items')
        nom = request.POST.get('nom')
        email = request.POST.get('email')
        phone = request.POST.get('phone')
        pays = request.POST.get('pays')
        address = request.POST.get('address')
        total = request.POST.get('total')
        
        # Créer la commande
        commande = Commande.objects.create(
            items=items,
            nom=nom,
            email=email,
            phone=phone,
            pays=pays,
            address=address,
            total=total
        )
        commande.save()
        return redirect('home')
        
    return render(request, 'store/checkout.html')

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
