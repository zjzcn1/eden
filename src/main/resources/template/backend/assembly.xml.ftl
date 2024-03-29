<assembly
	xmlns="http://maven.apache.org/plugins/maven-assembly-plugin/assembly/1.1.3"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://maven.apache.org/plugins/maven-assembly-plugin/assembly/1.1.3 http://maven.apache.org/xsd/assembly-1.1.3.xsd">
	<id>package</id>
	<formats>
		<format>zip</format>
	</formats>
	<includeBaseDirectory>false</includeBaseDirectory>
	<fileSets>
		<fileSet>
			<directory>config</directory>
			<outputDirectory>config</outputDirectory>
		</fileSet>
		<fileSet>
			<directory>bin</directory>
			<outputDirectory></outputDirectory>
			<fileMode>755</fileMode>
		</fileSet>
	</fileSets>

	<dependencySets>
		<dependencySet>
			<outputDirectory>lib</outputDirectory>
			<fileMode>0444</fileMode>
		</dependencySet>
	</dependencySets>
</assembly>
