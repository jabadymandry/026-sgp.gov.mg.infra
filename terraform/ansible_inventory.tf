resource "local_file" "ansible_inventory" {
    filename = "../ansible/inventory"
    content = templatefile("inventory.tmpl", 
    {
        ip          = aws_eip.sgp_eip.public_ip,
        dns         = aws_eip.sgp_eip.public_dns,
        tags        = aws_instance.front.tags
    })
}