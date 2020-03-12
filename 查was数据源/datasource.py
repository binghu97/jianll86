ds = AdminConfig.list('DataSource')
dsList = AdminUtilities.convertToList(ds)
d = open("/opt/IBM/dso.txt","w+")
j = open("/opt/IBM/jnd.txt","w+")
m = open("/opt/IBM/max.txt","w+")
n = open("/opt/IBM/min.txt","w+")
y = open("/opt/IBM/yum.txt","w+")
url = open("/opt/IBM/url.txt","w+")
for line in dsList:
	if line.find('Default') < 0:
		a = line.split("(")[0]
		d.write(a + "\n")
		#data = AdminConfig.getid('/DataSource:' + a + '/')
		jndi = AdminConfig.showall(line,'jndiName')
		jndii = jndi.split(" ")[1]
		jndiii = jndii.split("]")[0]
		j.write(jndiii + "\n")
		#conn = AdminConfig.getid('/DataSource:' + a + '/ConnectionPool:/')
		#conne = AdminUtilities.convertToList(conn)
		#for connection in conne:
		connection = AdminConfig.showAttribute(line,'connectionPool')
		max = AdminConfig.showAttribute(connection,'maxConnections')
		m.write(max + "\n")
		min = AdminConfig.showAttribute(connection,'minConnections')
		n.write(min + "\n")
		b = connection.split("/")[-1]
		c = b.split("|")[0]
		y.write(c + "\n")
		e = AdminConfig.showAttribute(line,'propertySet')
		f = AdminConfig.showAttribute(e,'resourceProperties')
		g = AdminUtilities.convertToList(f)
		for u in g:
			if u.find("URL") >=0:
				r = AdminConfig.showall(u,'value')
				l = r.replace('[','')
				o = l.replace('value','')
				p = o.replace(']','')
				url.write(p + "\n")
			elif u.find("url") >=0:
				ri = AdminConfig.showall(u,'value')
                                li = ri.replace('[','')
                                oi = li.replace('value','')
				pi = oi.replace(']','')
                                url.write(pi + "\n")
			elif u.find("serverName") >=0:
				rii = AdminConfig.showall(u,'value')
                                lii = rii.replace('[','')
                                oii = lii.replace('value','')
                                pii = oii.replace(']','')
                                url.write(pii + "\n")
			#else:
				#print "input error!!!";
			#endif
		#endfor
	#endif
#endfor
d.close()
j.close()
m.close()
n.close()
y.close()
url.close()

print "#################################"
