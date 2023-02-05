from django.contrib import admin
from chat.models import Messages, Thread


class MessageInline(admin.StackedInline):
    model = Messages
    fields = ('sender', 'text', 'timestamp')
    readonly_fields = ('sender', 'text', 'created_at')


class ThreadAdmin(admin.ModelAdmin):
    model = Thread
    inlines = (MessageInline,)

admin.site.register(Thread, ThreadAdmin)
