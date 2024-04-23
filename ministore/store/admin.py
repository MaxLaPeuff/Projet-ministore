from django.contrib import admin
from .models import Category, Product,CreateBlog,Comment,Commande

# Register your models here.

class AdminCategorie(admin.ModelAdmin):
    list_display=('name','date_created')
    
class AdminProduct(admin.ModelAdmin):
    list_display=('title','price','category','date_added')

    
class BlogAdmin(admin.ModelAdmin):
    list_display=('title','intro','slug','date_created')

class CommentAdmin(admin.ModelAdmin):
    list_display =('body','email','date_added')
    
class CommandeAdmin(admin.ModelAdmin):
    list_display=('items','nom','email','phone','address','total','date_created')

admin.site.register(Commande,CommandeAdmin)
admin.site.register(CreateBlog,BlogAdmin)
admin.site.register(Comment,CommentAdmin)
admin.site.register(Category,AdminCategorie)
admin.site.register(Product,AdminProduct)