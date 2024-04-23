from django.urls import path
from .views import List
from . import  views
urlpatterns = [
    path('',views.home, name='home'),
    path('shop',views.shop, name='shop'),
    path('<int:myid>',views.infos,name='infos'),
    path('checkout',views.checkout,name="checkout"),
    path('detail/<slug:slug>',views.detailView,name='detailView'),
    path('home', List.as_view(), name='home'),
    
]
