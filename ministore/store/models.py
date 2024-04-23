from django.db import models
from django.db.models.fields.related import ForeignKey
from django.utils import timezone

# Create your models here.

class Category(models.Model):
    name= models.CharField(max_length=200)
    date_created= models.DateTimeField(auto_now=True)
    
    class Meta:
        ordering =['-date_created']
        
    def __str__(self):
        return self.name
     
class Product (models.Model):
    title=models.CharField(max_length=200)
    price=models.FloatField()
    descvription = models.TextField()
    category =models.ForeignKey(Category, related_name='category', on_delete=models.CASCADE)
    image= models.ImageField(upload_to='media')
    date_added = models.DateTimeField(auto_now=True)
    
    class Meta:
        ordering =['-date_added']
        
    def __str__(self):
        return self.title

class CreateBlog(models.Model):
    title = models.CharField(max_length=100)
    slug = models.SlugField(unique=True, blank=True)
    intro=models.TextField(default='')
    body = models.TextField()
    image=models.ImageField(upload_to='media', default='' )
    date_created = models.DateTimeField(default=timezone.now)

    class Meta :
        ordering=['-date_created']

class Comment(models.Model):
    post= ForeignKey(CreateBlog,related_name='comments',on_delete=models.CASCADE)
    email=models.EmailField(default='')
    body=models.TextField(default='')
    name=models.CharField(max_length=100,default="inconnu")
    date_added=models.DateTimeField(auto_now=True)

    class Meta :
        ordering=['-date_added']
        
class Commande (models.Model):
    items=models.CharField(max_length=100)
    nom=models.CharField(max_length=100)
    email=models.EmailField()
    phone=models.CharField(max_length=100)
    pays=models.CharField(max_length=100)
    address=models.CharField(max_length=100)
    date_created=models.DateTimeField(auto_now=True)
    total=models.CharField(max_length=200)
    
    class Meta:
        ordering=['-date_created']
        

