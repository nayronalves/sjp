from django.urls import path
from . import views

app_name = 'associate'

urlpatterns = [
    path("", views.home, name="home")
]