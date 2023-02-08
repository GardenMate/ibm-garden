from django.shortcuts import render

# Create your views here.

# Create a simple chat view
def chat(request, username):
    return render(request, 'chat/lobby.html')