from django.shortcuts import render

from home.models import Associate


# Create your views here.
def home(request):
    associates = Associate.objects.all()
    return render(request, "associate/index.html", {"associates": associates})