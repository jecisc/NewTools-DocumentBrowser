Class {
	#name : #BaselineOfNewToolsDocumentBrowser,
	#superclass : #BaselineOf,
	#category : #BaselineOfNewToolsDocumentBrowser
}

{ #category : #baselines }
BaselineOfNewToolsDocumentBrowser >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
		spec preLoadDoIt: #'preload:package:'.
		spec
			baseline: 'Microdown'
			with: [
				spec
					repository: 'github://pillar-markup/Microdown:integration/src';
					loads: #('RichText') ].


		spec
			package: #'Microdown-RichTextPresenter'
				with: [ spec requires: #( #Microdown ) ];
			package: #'Microdown-RichTextPresenter-Tests'
				with: [ spec requires: #( #'Microdown-RichTextPresenter' ) ];

			package: #'NewTools-DocumentBrowser'
				with: [ spec requires: #( #'Microdown-RichTextPresenter') ];
			package: #'NewTools-DocumentBrowser-Tests'
				with: [ spec requires: #( #'NewTools-DocumentBrowser' ) ].

		spec
			group: 'Core' with: #(#'Microdown-RichTextPresenter' #'NewTools-DocumentBrowser');
			group: 'Tests' with: #('Core' #'Microdown-RichTextPresenter-Tests' #'NewTools-DocumentBrowser-Tests' );
			group: 'RichTextPresenter' with: #(#'Microdown-RichTextPresenter' #'Microdown-RichTextPresenter-Tests');
			group: 'All' with: #('Core' 'Tests' )
		]
]

{ #category : #baselines }
BaselineOfNewToolsDocumentBrowser >> preload: loader package: packageSpec [

	ProperMethodCategorizationTest compile: 'testInstanceSideInitializeMethodNeedsToBeInInitializationProtocol

	"The instance side #initialize methods should be in method protocol ''initialization''"

	| violating instanceSideInitializeMethods |
	violating := OrderedCollection new.
	instanceSideInitializeMethods := OrderedCollection new.

	Object allSubclassesDo: [:cls | cls methods do: [:m | (m selector = #initialize and: [ m isClassSide not  ]) ifTrue: [ instanceSideInitializeMethods add: m ]]].

	violating := instanceSideInitializeMethods select: [:m | m protocol ~= #initialization ].

	self assert: violating isEmpty description: ''Instance side #initialize methods should be in "class initialization" method category:'' , violating asString'
]
