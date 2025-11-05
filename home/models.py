from django.db import models

# Create your models here.
class Associate(models.Model):
    fullname = models.CharField(max_length=300)
    registry = models.CharField(max_length=20)
    email = models.EmailField(max_length=250, null=True)
    phone = models.CharField(max_length=20, null=True)
    status = models.BooleanField(default=True)
    created_at=models.DateTimeField(auto_now_add=True, null=True)
    updated_at=models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.fullname

    class Meta:
        db_table="associate"
        constraints = [
            models.UniqueConstraint(
                fields=['fullname', 'registry'],
                name='unique_fullname_registry'
            )
        ]